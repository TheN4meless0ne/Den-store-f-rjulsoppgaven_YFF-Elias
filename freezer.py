from portfolio.run import freezer

if __name__ == '__main__':
    try:
        freezer.freeze()
    except ValueError as e:
        print(f"Error during freezing: {e}")