class MathGenerator
  OPERATORS = [ '+', '-', '*', '/' ]

  def initialize(target_score, timeout)
    @target_score = target_score
    @timeout = timeout
    @r = Random.new
    @correct_answers = 0
  end

  def generate_pair(max)
    [@r.rand(max), @r.rand(max)]
  end

  def generate_task()
    op = OPERATORS[@r.rand(4)]
    # Gradually increasing difficulty
    scope = (@correct_answers / 10 + 1) * 10
    case op
    when '/'
      # We want to work with divisions witout remainders or decimals
      n2 = @r.rand(scope)
      n1 = n2 * @r.rand(scope)
    when '-'
      # Skip negative answers
      n2 = @r.rand(scope)
      n1 = n2 + @r.rand(scope)
    else
      n1, n2 = generate_pair(scope)
    end
    [n1, op, n2]
  end

  def run
    start_time = Time.now
    
    n1, op, n2 = generate_task
    puts "#{n1} #{op} #{n2}"
    loop do
      if Time.now - start_time > @timeout
        puts 'Time\'s up!'
        puts "You got #{@correct_answers} answers correct, #{@target_score} needed to get the flag"
        break
      end
      if IO.select([$stdin], nil, nil, 1)
        ans = gets.chomp
        if ans == n1.send(op, n2).to_s
          @correct_answers += 1
          if @correct_answers >= @target_score
            puts 'flag'
          end
        else
          puts 'Sorry, better luck next time'
          break
        end
        n1, op, n2 = generate_task
        puts "#{n1} #{op} #{n2}"
      end
    end
  end    
end

m = MathGenerator.new(100, 30).run

