import SelectAddressForm from "@/components/select-address-form";

export default function Page() {
  return (
    <div>
      <section>
        <h1 className="text-lg font-bold">Map</h1>
        <div>
          {/* TODO : 전역변수 설정 */}
          <SelectAddressForm label={"FROM"} country={"US"} />
          <SelectAddressForm label={"TO"} country={"US"} />
        </div>
      </section>

      <section>지도를 그를 부분</section>
    </div>
  );
}
