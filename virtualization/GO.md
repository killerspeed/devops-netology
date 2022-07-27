1  
```
vagrant@vagrant:~$ go version
go version go1.13.8 linux/amd64
```
2  
Изучено  

3  
Напишите программу для перевода метров в футы (1 фут = 0.3048 метр).


```markdown
vagrant@vagrant:~$ cat test.go
package main

import "fmt"

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)

    output := input * 0.3048
    fmt.Print("Mertes:")

    fmt.Println(output)
}
vagrant@vagrant:~$ go run test.go
Enter a number: 52
Mertes:15.8496
vagrant@vagrant:~$
```

Напишите программу, которая найдет наименьший элемент в любом заданном списке, например:

```markdown
vagrant@vagrant:~$ cat test1.go
package main

        import "fmt"

        func main() {
            x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17}
            current := 0
            fmt.Println ("Список значений : ", x)
            for i, value := range x {
                if (i == 0) {
                   current = value
                } else {
                    if (value < current){
                        current = value
                    }
                }
            }
            fmt.Println("Минимальное число : ", current)
        }
vagrant@vagrant:~$
vagrant@vagrant:~$ go run test1.go
Список значений :  [48 96 86 68 57 82 63 70 37 34 83 27 19 97 9 17]
Минимальное число :  9
```

Напишите программу, которая выводит числа от 1 до 100, которые делятся на 3. То есть (3, 6, 9, …).

```markdown
vagrant@vagrant:~$ cat test2.go
 package main

        import "fmt"


        func main() {

            for i := 1; i <= 100; i++ {
                if ((i-1)%10) ==0 {
                        fmt.Print(i-1," -> ")
                }

                if (i%3) == 0 {
                    fmt.Print(i,", ")
                    }
                if (i%10) ==0 {
                    fmt.Println()
                }
            }
        }
vagrant@vagrant:~$ go run test2.go
0 -> 3, 6, 9,
10 -> 12, 15, 18,
20 -> 21, 24, 27, 30,
30 -> 33, 36, 39,
40 -> 42, 45, 48,
50 -> 51, 54, 57, 60,
60 -> 63, 66, 69,
70 -> 72, 75, 78,
80 -> 81, 84, 87, 90,
90 -> 93, 96, 99,
vagrant@vagrant:~$
```