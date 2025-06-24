fn main(){
    for i in 1..10{
        for j in 1..9{
            print!("{:3},", i*j)
        }
        print!("{:3}", i*9);
        println!("")
    }
}