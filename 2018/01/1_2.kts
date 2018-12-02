import java.io.File

var sum = 0
val history = mutableSetOf(sum)

val freqs: List<Int> = File("input.txt").readLines().map{it.toInt()}
while (true) {
    freqs.forEach {
        sum += it
        if (!history.add(sum)) {
            println(sum)
            System.exit(0)
        }
    }
}