fn main() {
    for i in 1..101 {
        if i % 3 == 0 && i % 5 == 0 {
            println!("FIZZBUZZ")
        } else if i % 3 == 0 {
            println!("FIZZ")
        } else if i % 5 == 0 {
            println!("BUZZ")
        } else {
            println!("{}", i)
        }
    }
}
