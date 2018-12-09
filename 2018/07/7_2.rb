=begin
As you're about to begin construction, four of the Elves offer to help. "The sun will set soon; it'll go faster if we work together." Now, you need to account for multiple people working on steps simultaneously. If multiple steps are available, workers should still begin them in alphabetical order.

Each step takes 60 seconds plus an amount corresponding to its letter: A=1, B=2, C=3, and so on. So, step A takes 60+1=61 seconds, while step Z takes 60+26=86 seconds. No time is required between steps.

To simplify things for the example, however, suppose you only have help from one Elf (a total of two workers) and that each step takes 60 fewer seconds (so that step A takes 1 second and step Z takes 26 seconds). Then, using the same instructions as above, this is how each second would be spent:

Second   Worker 1   Worker 2   Done
   0        C          .        
   1        C          .        
   2        C          .        
   3        A          F       C
   4        B          F       CA
   5        B          F       CA
   6        D          F       CAB
   7        D          F       CAB
   8        D          F       CAB
   9        D          .       CABF
  10        E          .       CABFD
  11        E          .       CABFD
  12        E          .       CABFD
  13        E          .       CABFD
  14        E          .       CABFD
  15        .          .       CABFDE
Each row represents one second of time. The Second column identifies how many seconds have passed as of the beginning of that second. Each worker column shows the step that worker is currently doing (or . if they are idle). The Done column shows completed steps.

Note that the order of the steps has changed; this is because steps now take time to finish and multiple workers can begin multiple steps simultaneously.

In this example, it would take 15 seconds for two workers to complete these steps.

With 5 workers and the 60+ second step durations described above, how long will it take to complete all of the steps?
=end

require 'set'

def job_time(id)
    60 + id.downcase.ord - 'a'.ord + 1
end

open = Set.new
working = Set.new
timeleft = Hash.new
completed = Set.new
pres = Hash.new{Set.new}
order = ""
workers = 5

File.readlines("input.txt").each{ |line|
    toks = line.split
    id, dep = toks[1], toks[7]
    open <<= id
    open <<= dep
    pres[dep] <<= id
}

total_time = 0
while not open.empty? or not working.empty?
    available = open.select {|id| completed.superset? pres[id] and not working.include? id}.sort
    workers_available = workers - working.count
    
    new_jobs = available[0, workers_available]
    open -= new_jobs
    working += new_jobs
    timeleft.merge! Hash[new_jobs.collect{|id| [id, job_time(id)]}]

    min_timeleft = timeleft.values.min
    total_time += min_timeleft
    new_completed = timeleft.select {|_, timeleft| timeleft == min_timeleft}.keys
    timeleft = timeleft.map {|_, timeleft| [_, timeleft - min_timeleft] if timeleft > min_timeleft}.compact.to_h

    order += new_completed.sort.join
    completed += new_completed
    working -= new_completed
end
p total_time