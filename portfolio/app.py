from flask import Flask, render_template, send_from_directory, json, request
import os

app = Flask(__name__, template_folder='templates', static_folder='static')

@app.route('/')
def index():
    with open(os.path.join(app.root_path, '../infomodule/dataNO/dataportfolio.json'), encoding='utf-8') as f:
        portfolio_data = json.load(f)
    with open(os.path.join(app.root_path, '../infomodule/dataNO/dataindex.json'), encoding='utf-8') as f:
        index_data = json.load(f)
    return render_template('index.html', portfolioInfo=portfolio_data['portfolioInfo'], indexInfo=index_data['indexInfo'])

@app.route('/portfolio')
def portfolio():
    with open(os.path.join(app.root_path, '../infomodule/dataNO/dataportfolio.json'), encoding='utf-8') as f:
        portfolio_data = json.load(f)
    with open(os.path.join(app.root_path, '../infomodule/dataNO/image.json'), encoding='utf-8') as f:
        image_data = json.load(f)
    return render_template('page/portfolio.html', portfolioInfo=portfolio_data['portfolioInfo'], imageInfo=image_data['imageInfo'])

@app.route('/cv')
def cv():
    with open(os.path.join(app.root_path, '../infomodule/dataNO/pdf.json'), encoding='utf-8') as f:
        pdf_data = json.load(f)
    cv_pdf = next((pdf for pdf in pdf_data['pdfFiles'] if pdf['title'] == 'CV'), None)
    return render_template('page/cv.html', cv_pdf=cv_pdf)

@app.route('/files')
def downloads():
    with open(os.path.join(app.root_path, '../infomodule/dataNO/pdf.json'), encoding='utf-8') as f:
        pdf_data = json.load(f)
    return render_template('page/files.html', pdfs=pdf_data['pdfFiles'])

@app.route('/download/<filename>')
def download_file(filename):
    return send_from_directory(os.path.join(app.root_path, '../infomodule/pdf_files'), filename)

@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory(os.path.join(app.root_path, '../infomodule/images'), filename)

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404