import { Injectable } from '@nestjs/common';
import { diskStorage } from 'multer';
import { extname } from 'path';
import { v4 } from 'uuid';

@Injectable()
export class StorageService {
  getMulterOptions() {
    return {
      storage: diskStorage({
        destination: './upload',
        filename: (req, file, callback) => {
          const uniqueName = `${v4()}${extname(file.originalname)}`;
          callback(null, uniqueName);
        },
      }),
      limits: {
        fileSize: 10 * 1024 * 1024, // 10MB
      },
      fileFilter: (req, file, callback) => {
        if (!file.mimetype.match(/\/(jpg|jpeg|png|gif)$/)) {
          return callback(new Error('Only image files are allowed!'), false);
        }
        callback(null, true);
      },
    };
  }

  handleUploadedFile(file: Express.Multer.File): string {
    if (!file) {
      throw new Error('No file uploaded');
    }
    return `File uploaded successfully: ${file.filename}`;
  }
}
