from portfolio.app import freezer, app
import os

@freezer.register_generator
def url_generator():
    yield '/'
    yield '/portfolio'
    yield '/cv'
    yield '/files'

if __name__ == '__main__':
    try:
        # Ensure the build directory exists
        os.makedirs('build', exist_ok=True)
        print("Build directory created or already exists.")
        
        # Log all registered routes
        print("Registered routes:")
        for rule in app.url_map.iter_rules():
            print(rule)
        
        # Log URLs being processed
        print("URLs being processed:")
        for url in freezer.freeze_yield():
            print(url)
        
        freezer.freeze()
        print("Freezing completed.")
        
        # Log contents of the build directory
        print("Contents of build directory:")
        for root, dirs, files in os.walk('build'):
            for name in files:
                print(os.path.join(root, name))
    except ValueError as e:
        print(f"Error during freezing: {e}")
    except Exception as e:
        print(f"Unexpected error: {e}")