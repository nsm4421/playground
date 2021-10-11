from datasets import load_dataset
from transformers import AutoTokenizer, AutoModelForSequenceClassification
from transformers import Trainer
from transformers import TrainingArguments
import torch
import numpy as np
import argparse
from sklearn.metrics import accuracy_score
from Util import MyCollator, MyDataset, accuracy

if __name__ == '__main__':
    ## config
    parser = argparse.ArgumentParser()
    # 에포크
    parser.add_argument("--n_epoch", type=int, default=20)
    # 글자수 최대값
    parser.add_argument("--max_length", type=int, default=30)
    # 저장할 모델 이름
    parser.add_argument("--save_model_name", type=str, default='./saved_model')

    config = parser.parse_args()


    # 데이터셋 - 한국어 혐오발언
    """
        comment : 댓글
        labels: hate, offensive, none
    """
    dataset = load_dataset("kor_hate")
    train_comment = dataset['train']['comments']
    train_label = dataset['train']['hate']
    test_comment = dataset['test']['comments']
    test_label = dataset['test']['hate']

    # 데이터로더
    train_loader = MyDataset(train_comment, train_label)
    test_loader = MyDataset(test_comment, test_label)


    # GPU 사용 가능여부
    device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

    # tokenizer
    tokenizer = AutoTokenizer.from_pretrained("beomi/korean-hatespeech-classifier")

    # model
    model = AutoModelForSequenceClassification.from_pretrained("beomi/korean-hatespeech-classifier")

    # 훈련 argument
    training_args = TrainingArguments(
        output_dir='./.checkpoints',
        num_train_epochs=config.n_epoch,       # 에포크 수
        # fp16=True,                              # GPU 사용할 때 쓰면 빠르다고 함         
        # logging_steps=100,                      # 100번 iteration돌 때 마다 logging
        # save_steps=100,                         # 100번 iteration돌 때 마다 모델 저장
        evaluation_strategy="epoch"
    )

    # 훈련
    trainer = Trainer(
        model=model, 
        args=training_args,
        data_collator=MyCollator(tokenizer, config.max_length),
        train_dataset=train_loader,
        eval_dataset=test_loader,
        compute_metrics=accuracy     # 정확도
    )

    trainer.train()

    # 저장하기
    torch.save({
        'model_weight' : trainer.model.state_dict(),                    # 모델 weight
        'tokenizer' : tokenizer                                         # 토크나이저
    }, config.save_model_name)

