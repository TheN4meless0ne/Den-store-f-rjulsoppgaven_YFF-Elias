This project is a collection of me, and the projects I've worked on.

### How to install
#### Step 1
Clone the repository into a desired folder on you computer, and enter the folder.
``` Shell
git clone https://github.com/TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias
```

``` Shell
cd Den-store-f-rjulsoppgaven_YFF-Elias
```

#### Step 2
Before we can run the program we need to install the required PyPi packages.
``` Shell
pip install -r requirements.txt
```

#### Step 3
We want to make sure our submodule is initiated and up to date before starting the Flask app, we can do this from our terminal.
``` Shell
git submodule update --init --remote infomodule
```

#### Step 4
By running the `run.py` file through our terminal we start our Flask app.
``` Shell
python run.py
```

#### Step 5
Once the application is launced, you should get a message looking like this one.
``` Output
 * Serving Flask app 'app'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://yourip:5000
Press CTRL+C to quit
```

To enter your flask app you can write `http://127.0.0.1:5000` in your browser or click on of the http links in the terminal while holding down CTRL on your keyboard.
