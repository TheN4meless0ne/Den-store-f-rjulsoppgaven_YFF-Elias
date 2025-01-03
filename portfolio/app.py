from flask import Flask, render_template, send_from_directory, request
import os
import json
from dotenv import load_dotenv

app = Flask(__name__)

load_dotenv()
app.secret_key = os.getenv('SECRET_KEY')

@app.route('/')
def index():
    with open('../infomodule/dataNO/dataportfolio.json', encoding='utf-8') as f:
        portfolio_data = json.load(f)
    with open('../infomodule/dataNO/dataindex.json', encoding='utf-8') as f:
        index_data = json.load(f)
    return render_template('index.html', portfolioInfo=portfolio_data['portfolioInfo'], indexInfo=index_data['indexInfo'])

@app.route('/portfolio')
def portfolio():
    with open('../infomodule/dataNO/dataportfolio.json', encoding='utf-8') as f:
        portfolio_data = json.load(f)
    with open('../infomodule/dataNO/image.json', encoding='utf-8') as f:
        image_data = json.load(f)
    return render_template('page/portfolio.html', portfolioInfo=portfolio_data['portfolioInfo'], imageInfo=image_data['imageInfo'])

@app.route('/cv')
def cv():
    with open('../infomodule/dataNO/pdf.json') as f:
        pdf_data = json.load(f)
    cv_pdf = next((pdf for pdf in pdf_data['pdfFiles'] if pdf['title'] == 'CV'), None)
    return render_template('page/cv.html', cv_pdf=cv_pdf)

@app.route('/files')
def downloads():
    with open('../infomodule/dataNO/pdf.json') as f:
        pdf_data = json.load(f)
    return render_template('page/files.html', pdfs=pdf_data['pdfFiles'])

@app.route('/download/<filename>')
def download_file(filename):
    return send_from_directory('../infomodule/pdf_files', filename)

@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory('../infomodule/images', filename)

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')