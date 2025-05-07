import { FindOptionsOrder, FindOptionsWhere, Repository } from 'typeorm';

export interface Pageable<T> {
  data: T[];
  totalCount: number;
  pageSize: number;
  currentPage: number;
  totalPages: number;
}

/**
 * Fetching With Pagination
 * @param
 * - repsitory
 * - page
 * - pageSize
 * - where
 * - order
 * @returns data
 * - data
 * - totalCount
 * - pageSize
 * - order
 */
export async function fetchWithPagination<T>({
  repository,
  page,
  pageSize,
  where,
  order,
}: {
  repository: Repository<T>;
  page: number;
  pageSize: number;
  order?: FindOptionsOrder<T>;
  where?: FindOptionsWhere<T> | FindOptionsWhere<T>[];
}) {
  const [data, totalCount] = await repository.findAndCount({
    skip: (page - 1) * pageSize,
    take: pageSize,
    order,
    where,
  });
  return {
    data,
    totalCount,
    pageSize,
    currentPage: page,
    totalPages: Math.ceil(totalCount / pageSize),
  };
}
