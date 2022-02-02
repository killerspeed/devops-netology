1-) Выполнено
5) 
 ram -1024
 cpu 1
 hdd 64 гб
6) мой конфиг 
 Vagrant.configure("2") do |config|
    # usual vagrant config here
    config.vm.box = "bento/ubuntu-20.04"
    config.vm.provider "virtualbox" do |v|
    v.name = "devops-netology"
    v.customize ["modifyvm", :id, "--cpuexecutioncap", "35"]
        v.memory = 2048
    end
end
8) 
 Для этой задачи было зайдественно команды:
 - man bash
 - -N
 - /HISTSIZE
у меня номер строки 862

ignoreboth это сокращение для 2х директив ignorespace and ignoredups, 
 ignorespace — не сохранять строки начинающиеся с символа <пробел>
 ignoredups — не сохранять строки, совпадающие с последней выполненной командой
9) 
 В man bash, не нашел, нашел в инте, как я понял будет создавть поледовательно например mkdir ./DIR_{0..100}.
10) 
 Ссылаясь на предыдущие задание с помощью touch {000001..100000}.txt
-bash: /usr/bin/touch: Argument list too long - это слишком длинный список 
11) 
 Проверяет условие у -d /tmp и возвращает ее статус (0 или 1), наличие катаолга /tmp
12) 
 root@vagrant:/home/vagrant# mkdir /tmp/new_path_directory/
root@vagrant:/home/vagrant# cp /bin/bash /tmp/new_path_directory/

root@vagrant:/home/vagrant# type -a bash
bash is /tmp/new_path_directory/bash
bash is /usr/bin/bash
bash is /bin/bash
13)
at
запускает команды в заданное время.
batch
запускает команды, когда уровни загрузки системы позволяют это делать; в других, когда средняя загрузка системы, читаемая из /proc/loadavg, опускается ниже 0.5, или величины, заданной при вызове atrun.
14) 
vagrant suspend
