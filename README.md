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
We want to make sure our submodule is up to date before starting the Flask app, we can do this from our terminal.
``` Shell
git submodule update --remote infomodule
```

#### Step 4
Now it is time to start the Flask app.

To do this we first need to enter the folder where the file `app.py` is located. In this project it is called `portfolio`.
``` Shell
cd portfolio
```

Once we're in the folder, we are able to run `app.py` through our terminal which then starts our Flask app.
``` Shell
python app.py
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
