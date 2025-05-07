import {
  Accordion,
  Badge,
  Box,
  Button,
  Chip,
  Group,
  Radio,
  Select,
  Slider,
  TextInput,
} from "@mantine/core";
import { IconFilter, IconSearch, IconTrash } from "@tabler/icons-react";
import { SetStateAction, useEffect, useState, Dispatch } from "react";

export default function SearchArticle({
  pageNumber,
  setPageNumber,
  setEndPoint,
  getArticles,
  setIsLoading,
}: {
  pageNumber: number;
  setPageNumber: Dispatch<SetStateAction<number>>;
  setEndPoint: Dispatch<SetStateAction<string | null>>;
  getArticles: Function;
  setIsLoading: Dispatch<SetStateAction<boolean>>;
}) {
  const [isSearchChecked, setIsSearchChecked] = useState<boolean>(false);
  const [isSortChecked, setIsSortChecked] = useState<boolean>(false);
  const [isSizeChecked, setIsSizeChecked] = useState<boolean>(false);
  const [searchType, setSearchType] = useState<string | null>("TITLE");
  const [searchText, setSearchText] = useState<string>("");
  const [sort, setSort] = useState<string | undefined>(undefined);
  const [size, setSize] = useState<number>(20);

  useEffect(() => {
    setSearchType(null);
    setSearchText("");
    return;
  }, [isSearchChecked]);

  useEffect(() => {
    setSort(undefined);
    return;
  }, [isSortChecked]);

  useEffect(() => {
    setSize(20);
    return;
  }, [isSizeChecked]);

  // state 변경 시 endPoint 수정
  useEffect(() => {
    setEndPoint(
      `http://localhost:8080/api/article?&page=${pageNumber - 1}` +
        (searchType && searchText
          ? `&search-type=${searchType}&search-text=${searchText}`
          : "") +
        (sort
          ? `&sort-field=${sort.split(".")[0]}&sort-direction=${sort.split(".")[1]}`
          : "") +
        (size ? `&size=${size ?? 20}` : "")
    );
  }, [searchType, searchText, sort, size, pageNumber]);

  // Apply 버튼 누를 때 검색옵션 적용한 게시글로 갱신하기
  const handleClickApplyButton = async () => {
    setIsLoading(true);
    setPageNumber(1);
    await getArticles();
    setIsLoading(false);
  };

  // Clear 버튼 누를 때 검색옵션 제거한 게시글로 갱신하기
  const handleClickClearButton = async () => {
    setIsLoading(true);
    await setPageNumber(1);
    // 검색옵션 초기화
    await setIsSearchChecked(false);
    await setIsSortChecked(false);
    await setIsSizeChecked(false);
    // 게시글 갱신
    await getArticles();
    setIsLoading(false);
  };

  // 검색옵션 사용여부
  const handleIsSearchChecked = () => {
    setIsSearchChecked(!isSearchChecked);
  };
  // 정렬옵션 사용여부
  const handleIsSortCheked = () => {
    setIsSortChecked(!isSortChecked);
  };
  // 페이지당 게시글 수 옵션 사용여부
  const handleIsSizeChecked = () => {
    setIsSizeChecked(!isSizeChecked);
  };

  // 검색 옵션 - 제목 / 본문 / 해시태그 / 작성자
  const searchOptionData = [
    { value: "TITLE", label: "Title" },
    { value: "CONTENT", label: "Content" },
    { value: "HASHTAG", label: "Hashtag" },
    { value: "USER", label: "Author" },
  ];

  return (
    <Accordion variant="separated" radius="md" transitionDuration={400}>
      <Accordion.Item value="search">
        <Accordion.Control>
          <Badge>Options</Badge>
        </Accordion.Control>

        {/* 검색기능 */}
        <Accordion.Panel>
          <Chip checked={isSearchChecked} onChange={handleIsSearchChecked}>
            Search
          </Chip>
          {isSearchChecked && (
            <Box p="sm">
              <Group position="left">
                {/* 검색유형 */}
                <Select
                  value={searchType}
                  onChange={setSearchType}
                  label="Search Type"
                  placeholder="what to search?"
                  data={searchOptionData}
                  defaultValue="TITLE"
                  maw={"200px"}
                />
                {/* 검색어 */}
                <TextInput
                  value={searchText}
                  onChange={(e) => {
                    setSearchText(e.currentTarget.value);
                  }}
                  label="Search Text"
                  icon={<IconSearch />}
                  miw={"500px"}
                />
              </Group>
            </Box>
          )}
        </Accordion.Panel>

        {/* 정렬기준 */}
        <Accordion.Panel>
          <Chip checked={isSortChecked} onChange={handleIsSortCheked}>
            Sort
          </Chip>
          {isSortChecked && (
            <Box p="sm">
              <Radio.Group
                value={sort}
                onChange={setSort}
                name="How to Sort?"
                label="How to Sort?"
                description="Default is created at, descreasing"
                defaultValue="CREATED_AT.DESC"
              >
                <Group mt="xs">
                  <Radio value="title.ASC" label="△ Title" />
                  <Radio value="title.DESC" label="▽ Title" />
                  <Radio value="createdBy.ASC" label="△ Author" />
                  <Radio value="createdBy.DESC" label="▽ Author" />
                </Group>
              </Radio.Group>
            </Box>
          )}
        </Accordion.Panel>

        {/* 페이지 당 게시글 수 */}
        <Accordion.Panel>
          <Chip checked={isSizeChecked} onChange={handleIsSizeChecked}>
            Article Per Page
          </Chip>
          {isSizeChecked && (
            <Box p="sm">
              <Slider
                value={size}
                onChangeEnd={setSize}
                color="indigo"
                radius="lg"
                size="lg"
                min={10}
                max={50}
                labelAlwaysOn
                labelTransitionDuration={150}
                marks={[
                  { value: 10, label: "10(min)" },
                  { value: 50, label: "50(max)" },
                ]}
              />
            </Box>
          )}
        </Accordion.Panel>

        <Accordion.Panel>
          <Group position="right" mt="md">
            {/* 옵션 적용하기 버튼 */}
            <Button
              onClick={handleClickApplyButton}
              leftIcon={<IconFilter />}
              color="green"
            >
              Apply
            </Button>

            {/* 옵션 삭제하기 버튼 */}
            <Button onClick={handleClickClearButton} leftIcon={<IconTrash />}>
              Clear
            </Button>
          </Group>
        </Accordion.Panel>
      </Accordion.Item>
    </Accordion>
  );
}
