from datasets import load_dataset
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from transformers import Trainer
from transformers import TrainingArguments
import numpy as np
from sklearn.metrics import accuracy_score

dataset = load_dataset("kor_hate")
train_comment = dataset['train']['comments']
train_label = dataset['train']['hate']
test_comment = dataset['test']['comments']
test_label = dataset['test']['hate']

# tokenizer
tokenizer = AutoTokenizer.from_pretrained("beomi/korean-hatespeech-classifier")

# model
model = AutoModelForSequenceClassification.from_pretrained("beomi/korean-hatespeech-classifier")

# 토크나이져
sample= "아 내일 또 출근하는거 실화냐"
token = tokenizer(sample)
print(f"{sample} --- 토크나이징 ---> {token}")

# 모델 추론
sample = "아 너무너무 빡치자나"
token = tokenizer.encode_plus(sample, return_tensors="pt")
output = model(**token)
print(f"샘플 입력 : {sample}")
print(f"Ouput : {output}")
print(f"logit : {output.logits}")
