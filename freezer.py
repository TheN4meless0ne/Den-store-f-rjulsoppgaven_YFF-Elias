from portfolio.app import freezer
import os

if __name__ == '__main__':
    try:
        # Ensure the build directory exists
        os.makedirs('build', exist_ok=True)
        print("Build directory created or already exists.")
        freezer.freeze()
        print("Freezing completed.")
        print("Contents of build directory:")
        for root, dirs, files in os.walk('build'):
            for name in files:
                print(os.path.join(root, name))
    except ValueError as e:
        print(f"Error during freezing: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")