function stacknew -a name
    if test (count $argv) -ne 1
        echo "Set create project name."
    else
        stack new $name -p "author-email:yukimemi@gmail.com" -p "author-name:yukimemi" -p "category:Development" -p "copyright:(c) 2017, yukimemi" -p "github-username:yukimemi"
    end
end
