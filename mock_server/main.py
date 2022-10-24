# main.py


from unittest import mock
from fastapi import FastAPI
from fastapi.responses import JSONResponse
import json
from typing import Union

app = FastAPI()

@app.get("/")
async def root():
    
    return {}

@app.get("/data/2.5/weather", status_code=200)
async def current(lat: str = "", lon: str = "", appid: str = ""):
    auth = json.load(open("./data/mock/auth.json"))
    if (appid == auth):
        file_object = open("./data/mock/401.json")
        return JSONResponse(
            status_code=401,
            content=json.load(file_object),
            )
    if (lat == "") or (lon == ""):
        file_object = open("./data/mock/400.json")
        return JSONResponse(
            status_code=400,
            content=json.load(file_object),
            )
        
    else:
        file_object = open("./data/mock/sample.json")

    return json.load(file_object)


if  __name__ == "__main__":
    app = FastAPI()