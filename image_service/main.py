from fastapi import FastAPI, UploadFile, File, HTTPException
from fastapi.responses import FileResponse
import uuid
import os

# Katalog na obrazki
IMAGE_DIR = "images"
os.makedirs(IMAGE_DIR, exist_ok=True)

app = FastAPI()


@app.post("/images/")
async def upload_images(files: list[UploadFile] = File(...)):
    """
    Zapisuje przesłane obrazki na dysk i zwraca ich ID.
    """
    saved_files = []

    for file in files:
        image_id = str(uuid.uuid4())
        file_extension = os.path.splitext(file.filename)[-1] 
        file_path = os.path.join(IMAGE_DIR, f"{image_id}{file_extension}")

        with open(file_path, "wb") as f:
            f.write(await file.read())

        saved_files.append({"id": image_id, "filename": file.filename})

    return {"uploaded_files": saved_files}


@app.get("/images/{image_id}")
async def get_image(image_id: str):
    """
    Pobiera obrazek o podanym ID z dysku.
    """
    for file_name in os.listdir(IMAGE_DIR):
        if file_name.startswith(image_id):
            file_path = os.path.join(IMAGE_DIR, file_name)
            return FileResponse(file_path)

    raise HTTPException(status_code=404, detail="Image not found")