"""Compute rows of (1 + x + ... + x^15)^n using exact integer arithmetic."""

from argparse import ArgumentParser


def next_row(row: list[int]) -> list[int]:
    """Multiplication by 1 + x + ... + x^15 takes sliding sums of 16 terms."""
    next_coeffs = []
    window = 0
    for index in range(len(row) + 15):
        if index < len(row):
            window += row[index]
        if index >= 16:
            window -= row[index - 16]
        next_coeffs.append(window)
    return next_coeffs


def check(max_n: int) -> None:
    if max_n < 0:
        raise ValueError("max_n must be nonnegative")

    # Opening terms printed in the primary OEIS entry, revision 13.
    published = (1, 1, 16, 192, 2736, 39280, 577744, 8582336, 128912240, 1947652092)
    row = [1]
    even_rows = 0
    for n in range(max_n + 1):
        center = row[(15 * n) // 2]
        if n < len(published) and center != published[n]:
            raise AssertionError(f"Published value mismatch at n={n}: {center}")
        if n % 2 == 0:
            expected = ((15 * n) // 2).bit_count()
            # Test divisibility and failure of divisibility by the next power of 2.
            if center % (1 << (expected + 1)) != (1 << expected):
                raise AssertionError(f"Incorrect valuation at n={n}, expected {expected}")
            even_rows += 1
        if n < max_n:
            row = next_row(row)

    print(f"Checked {even_rows} even rows from n=0 to n={max_n - max_n % 2}.")
    print(f"Matched {min(max_n + 1, len(published))} published opening coefficients.")


if __name__ == "__main__":
    parser = ArgumentParser(description=__doc__)
    parser.add_argument("--max-n", type=int, default=1600)
    check(parser.parse_args().max_n)
