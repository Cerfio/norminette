# coding: utf-8
# Project Norminette in ruby
# Cerfio

require 'colorize'

ARGV

function_banned = ["printf", "atoi", "puts", "getline", "realloc", "strlen", "strcmp", "atol"]

def check_pointeur(line, i)
  jump_pointeur = 0;
end

def check_header(i, line, after)
  if (i == 0 && line[0] != "/")
    puts("Pas de Header")
    return (1)
  end
  if (i == 0)
    return (0)
  end
  if (line[0] != "*")
    puts("Header invalide " + i.to_s)
    return (1)
  end
  if (line[0] == "*" && line[1] == "/")
    if (after[0] != "\n")
      puts("Saut de ligne manquand apres le Header")      
    end
    return (1)
  end
  return (0)
end

def check_space(line, i)
  count = 0
  len = 0
  while (line[len] != "\n")
    if (line[len] >= "a" && line[len] <= "z" || line[len] >= "A" && line[len] <= "Z")
      break
    end
    if (line[len] == " ")
      puts("Espace en trop en début de ligne " + i.to_s + " minor(L3)".green)
    end
    len = len + 1
  end
  while (line[len] != "\n")
    if (line[len] == " " && line[len + 1] == " ")
      puts("Espace en trop au caractere " + len.to_s + " line " + i.to_s + " minor(L3)".green)
    end
    len = len + 1
  end
  len = line.length 
  if (line[len - 2] == " ")
    puts("Espace en trop en fin de ligne " + i.to_s + " minor(L3)".green)
  elsif (line[len - 2] == "\t")
    puts("Tabulation en trop en fin de ligne " + i.to_s + " minor(L3)".green)
  end
end

def check_new_line_function(line, line_before, i)
  numberline = i + 1
  if (i > 0 && line_before[0] == "}" && line[0] != "\n")
    puts("Saut de ligne manquant ligne " + numberline.to_s)
  end
end

def check_control_variable(line, i)
  if (line.include?(",") == true)
    puts("Declaration de plusieur variable sur la meme ligne ligne " + i.to_s + " minor(L5)".green)
  end
end

def check_uppercase(line, i)
  count = 0
  while (line[count] != "\n")
    if (line[count] >= "A" && line[count] <= "Z")
      puts("Variable ou fonction en majuscule ligne " + i.to_s)
      return (0)
    end
    count = count + 1
  end
end

def check_long_line(line, i)
  len = 0
  count = 0
  while (line[count] != "\n")
    if (line[count] == "\t")
      len = len + 7
    end
    len = len + 1
    count = count + 1
  end
  if (len > 80)
    puts("Ligne trop longue " + len.to_s + " ligne " + i.to_s + " major(F3)".red)
  end
end

def check_goto(line, i)
  if (line.include?("goto") == true)
    puts("Goto interdit ligne " + i.to_s + " minor(C3)".green)
  end
end

def argument_function(line, i)
  len = 0
  count = 0
  name_function = line.split("(")
  name_function = name_function[0].split(" ")
  if (name_function.length > 1 && line.count("(") >= 1 && line[line.length - 3] == "(")
    puts("Void manquant dans la declaration de fonction ligne " + i.to_s + " major(F5)".red)
    return (0)
  end
  while (line[count] != "\n")
    if (line[count] == ",")
      len = len + 1
    end
    count = count + 1
  end
  if (len > 3)
    puts("Trop d'argument à la fonction " + name_function[name_function.length - 1] +  " " + len.to_s + " ligne " + i.to_s + " major(F5)".red)
  end
end

def read_file
  fichier = File.open(ARGV[0],'r').readlines
  i = 0
  while (check_header(i, fichier[i], fichier[i + 1]) != 1)
    i = i + 1
  end
  i = i + 2
  while (fichier[i])
    check_control_variable(fichier[i], i + 1)
    check_goto(fichier[i],i + 1)
    check_uppercase(fichier[i], i + 1)
    argument_function(fichier[i], i + 1)
    check_space(fichier[i], i + 1)
    check_new_line_function(fichier[i], fichier[i - 1], i)
    check_long_line(fichier[i], i + 1)
    i = i + 1
  end
end

read_file()
