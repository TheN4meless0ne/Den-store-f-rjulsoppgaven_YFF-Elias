from portfolio.app import freezer
import os

if __name__ == '__main__':
    try:
        # Ensure the build directory exists
        os.makedirs('build', exist_ok=True)
        freezer.freeze()
    except ValueError as e:
        print(f"Error during freezing: {e}")