interface Item {
  id: string;
  title: string;
  postNum?: number;
}

function TrendItem({ id, title, postNum }: Item) {
  return (
    <div
      id={`trend-item-${id}`}
      className="cursor-pointer flex-col flex-start gap-x-3 items-center group"
    >
      <p className="text-md truncate font-normal group-hover:text-sky-600 group-hover:font-bold">
        {title}
      </p>
      {postNum && (
        <label className="text-xs text-slate-600 font-extralight">
          {postNum} posts
        </label>
      )}
    </div>
  );
}
interface Props {
  trends: Item[];
}

export default function TrendSection({ trends }: Props) {
  return (
    <div className="bg-slate-100 rounded-lg px-3 py-2 max-h-fit">
      <h1 className="text-lg font-bold">Current Trend</h1>
      <ul className="flex flex-col gap-y-2 my-2">
        {trends.map((item, idx) => (
          <li key={item.id}>
            <TrendItem
              id={`${idx}`}
              title={item.title}
              postNum={item.postNum}
            />
          </li>
        ))}
      </ul>
    </div>
  );
}
