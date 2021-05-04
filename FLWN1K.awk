$1 ~ /^[[:alpha:]]/ { f[$1] = $2 }

$1 == "DATASET UNSTRUCTURED_GRID" {
    block = $1
    print "TITLE  Output"
    print ""
    printf "NMSHPOINTS %d \n", f["POINTS"]
    printf "NNODES %d \n", f["POINTS"]
    printf "NELEMENTS_TRIANG1 %d \n", f["CELLS"]
    print ""
    print "MESHPOINT_COORDINATES"
    next
}

block == "DATASET UNSTRUCTURED_GRID" {
    $1 = ""
    printf "%s"
    sub(/^[[:space:]]+/,"")
    print
}

$1 == "CELLS" {
    block = $1
    printf "\nNODES_TRIANG1\n"
    next
}

block == "CELLS" {
    printf "%s"
    
    for (i=2; i<=NF; i++) {
        printf " %s", $i + 1
    }
    print ""
}
