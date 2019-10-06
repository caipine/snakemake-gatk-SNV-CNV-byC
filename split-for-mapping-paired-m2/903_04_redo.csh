foreach normal ( "`cat 904.normal.list.redo`" )
mv split-to-${normal}/called split-to-${normal}/calledX
sbatch split-to-${normal}/sb.sh 
end


