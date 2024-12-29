import { createHash } from 'crypto';

/**
 * 두개의 uuid를 받아서 새로운 uuid를 생성하는 함수
 * @param uuid1
 * @param uuid2
 * @returns uuid
 */
export function generateUuid(uuid1: string, uuid2: string): string {
  const sortedUuidList = [uuid1, uuid2].sort();
  return createHash('sha256').update(sortedUuidList.join('|')).digest('hex');
}
