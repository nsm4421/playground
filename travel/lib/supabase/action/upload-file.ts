import createSupabaseBrowerCleint from "../client/browser-client";

interface Props {
  bucketName: string;
  filename: string;
  file: File;
  upsert: boolean;
}

export default async function UploadFileAction(props: Props) {
  const supabase = createSupabaseBrowerCleint();

  const { data, error } = await supabase.storage
    .from(props.bucketName)
    .upload(props.filename, props.file, {
      cacheControl: "3600",
      upsert: props.upsert,
    });

  if (error) {
    throw error;
  }

  const {
    data: { publicUrl },
  } = supabase.storage.from(props.bucketName).getPublicUrl(data.path);
  return publicUrl;
}
