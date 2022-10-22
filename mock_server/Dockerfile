FROM python:3.6.9
RUN mkdir /app
WORKDIR /app
COPY ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt
COPY ./ .
# CMD ["/bin/bash"]
# uvicorn main:app --reload
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]