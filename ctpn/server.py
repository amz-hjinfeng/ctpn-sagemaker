
from flask import Flask,render_template,request,redirect,url_for,Response
from werkzeug.utils import secure_filename
from io import BytesIO
from PIL import Image
import text_detect as tdx
import os
import numpy as np

app = Flask(__name__)




@app.route('/')
def hello_world():
      return 'Hello World!'

@app.route('/api/detect-image',methods = ['GET','POST'])
def detectText():
      file_name="Nothing.jpg"
      staticFilePath = 'static/output'
      if request.method=='POST':
        f = request.files["file"]
        byte_io = BytesIO()
        im = Image.open(f,mode='r')
        img = np.array(im.convert('RGB'))
        img_out = tdx.td(img)
        return Response(img_out,mimetype="image/jpeg")
      return render_template('image_uploader.html', path = file_name)


if __name__ == '__main__':
      app.run()

