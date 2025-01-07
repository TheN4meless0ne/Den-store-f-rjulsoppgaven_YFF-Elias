from flask import Flask, render_template, send_from_directory, json, request, session, redirect, url_for
import os
from dotenv import load_dotenv
from flask_frozen import Freezer

load_dotenv()  # Load environment variables from .env file

app = Flask(__name__, template_folder='templates', static_folder='static')
app.secret_key = os.getenv('SECRET_KEY')  # Get the secret key from environment variables
freezer = Freezer(app)

def normalize_path(relative_path):
    return os.path.abspath(os.path.join(app.root_path, relative_path))

def load_data(language):
    data_path = f'../infomodule/data{language}'
    translation_path = f'../infomodule/translations/translations{language}.json'

    portfolio_path = normalize_path(f'{data_path}/dataportfolio.json')
    index_path = normalize_path(f'{data_path}/dataindex.json')
    image_path = normalize_path(f'{data_path}/image.json')
    pdf_path = normalize_path(f'{data_path}/pdf.json')
    translation_path = normalize_path(translation_path)

    with open(portfolio_path, encoding='utf-8') as f:
        portfolio_data = json.load(f)
    with open(index_path, encoding='utf-8') as f:
        index_data = json.load(f)
    with open(image_path, encoding='utf-8') as f:
        image_data = json.load(f)
    with open(pdf_path, encoding='utf-8') as f:
        pdf_data = json.load(f)
    with open(translation_path, encoding='utf-8') as f:
        translations = json.load(f)
    
    return portfolio_data, index_data, image_data, pdf_data, translations


@app.route('/')
def index():
    language = session.get('language', 'NO')
    portfolio_data, index_data, _, _, translations = load_data(language)
    return render_template('index.html', portfolioInfo=portfolio_data['portfolioInfo'], indexInfo=index_data['indexInfo'], translations=translations)

@app.route('/portfolio')
def portfolio():
    language = session.get('language', 'NO')
    portfolio_data, _, image_data, _, translations = load_data(language)
    return render_template('page/portfolio.html', portfolioInfo=portfolio_data['portfolioInfo'], imageInfo=image_data['imageInfo'], translations=translations)

@app.route('/cv')
def cv():
    language = session.get('language', 'NO')
    _, _, _, pdf_data, translations = load_data(language)
    cv_pdf = next((pdf for pdf in pdf_data['pdfFiles'] if pdf['title'] == 'CV'), None)
    return render_template('page/cv.html', cv_pdf=cv_pdf, translations=translations, show_sidebar=False)

@app.route('/files')
def downloads():
    language = session.get('language', 'NO')
    _, _, _, pdf_data, translations = load_data(language)
    return render_template('page/files.html', pdfs=pdf_data['pdfFiles'], translations=translations, show_sidebar=False)

@app.route('/download/<filename>')
def download_file(filename):
    return send_from_directory(os.path.join(app.root_path, '../infomodule/pdf_files'), filename)

@app.route('/images/<filename>')
def serve_image(filename):
    return send_from_directory(os.path.join(app.root_path, '../infomodule/images'), filename)

@app.route('/set_language/<language>')
def set_language(language):
    session['language'] = language
    return redirect(request.referrer or url_for('index'))

@app.errorhandler(404)
def page_not_found(e):
    language = session.get('language', 'NO')
    _, _, _, _, translations = load_data(language)
    return render_template('404.html', translations=translations, show_sidebar=False), 404