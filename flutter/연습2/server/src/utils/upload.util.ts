import { FileInterceptor, FilesInterceptor } from '@nestjs/platform-express';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 } from 'uuid';

interface GenSingleImageOption {
  fileKey: string; // intercept하기 위한 파일 키값
  destination: string; // 파일 저장 경로
  acceptOnlyImage?: boolean; // mime타입이 jpg|jpeg|png|gif인 파일만 업로드 가능
  fileSize?: number; // 최대 업로드 가능한 파일 용량
}

interface GenMultiImageOption extends GenSingleImageOption {
  maxFileNum?: number; // 최대 업로드 가능한 파일 개수
}

function genStorage(destination: string) {
  return diskStorage({
    destination,
    filename: (req, file, callback) => {
      const uniqueName = `${v4()}${extname(file.originalname)}`;
      callback(null, uniqueName);
    },
  });
}

function genLimit(fileSize?: number) {
  return {
    fileSize: fileSize ?? 10 * 1024 * 1024, // 10MB
  };
}

export function genSingleFileMulterOption({
  fileKey,
  destination,
  acceptOnlyImage,
  fileSize,
}: GenSingleImageOption) {
  return FileInterceptor(fileKey, {
    storage: genStorage(destination),
    limits: genLimit(fileSize),
    fileFilter: (req, file, callback) => {
      if (acceptOnlyImage && !file.mimetype.match(/\/(jpg|jpeg|png|gif)$/)) {
        return callback(new Error('Only image file is allowed!'), false);
      }
      callback(null, true);
    },
  });
}

export function genMultiFileMulterOption({
  fileKey,
  destination,
  acceptOnlyImage,
  fileSize,
  maxFileNum,
}: GenMultiImageOption) {
  return FilesInterceptor(fileKey, maxFileNum, {
    storage: genStorage(destination),
    limits: genLimit(fileSize),
    fileFilter: (req, file, callback) => {
      if (acceptOnlyImage && !file.mimetype.match(/\/(jpg|jpeg|png|gif)$/)) {
        return callback(new Error('Only image files are allowed!'), false);
      }
      callback(null, true);
    },
  });
}
