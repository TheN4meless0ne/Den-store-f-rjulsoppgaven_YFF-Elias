from flask import Flask, render_template, request
import os
from dotenv import load_dotenv

app = Flask(__name__)

load_dotenv()
app.secret_key = os.getenv('SECRET_KEY')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/cv')
def cv():
    return render_template('page/cv.html')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')