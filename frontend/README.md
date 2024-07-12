# RLS (row level security)

### Create Account Table

create table
accounts (
id uuid references auth.users not null primary key,
email text,
nickname text unique constraint nickname_length check (char_length(nickname) <= 20)
);

alter table profiles enable row level security;

create policy "user can only insert own account" on accounts for insert
with check (auth.uid () = id);

create policy "user can only update own account" on accounts for update
with check (auth.uid () = id);

CREATE FUNCTION public.add_account()
RETURNS trigger AS $$
BEGIN
INSERT INTO public.accounts (id, email, nickname)
VALUES (NEW.id, NEW.email, NEW.raw_user_meta_data->>'nickname');
RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR EACH ROW
EXECUTE PROCEDURE public.add_account();
