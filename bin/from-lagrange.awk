BEGIN {
    begun = 0
}

/^## / {
    begun = 1
}

/^=> / {
    if (begun == 1) {
        print $0
    }
}
