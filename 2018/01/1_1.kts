import java.io.File

val sum = File("input.txt").readLines().map{it.toInt()}.sum()
println(sum)