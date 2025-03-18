

$images = dir static/images/platypsv1/
$date = Get-Date -Format 'yyyy-MM-dd'
$image = $images[0].Name
$title = 'PlatyPS v1.0'
$linkTitle = 'PlatyPS v1.0'
$weight = 8
$navWeight = -8000

$indexfm = @"
---
linkTitle: $linkTitle
title: $title
linkTitleIcon: <i class="fab fa-git-alt"></i>
weight: $weight
navWeight: -4000
date: $date
---
<!-- markdownlint-disable MD041 -->

## $title

![$title][01]

<!-- link references -->
[01]: $image
"@
$indexfm | Out-File -FilePath content\docs\10-platypsv1\_index.md -Encoding utf8

foreach ($i in 1..($images.Count-1)) {
    $image = $images[$i].Name
    $title = $images[$i].BaseName
    $weight = $i
    $navWeight = $images.Count - $i + 1
    $slide = $images[$i].BaseName + '.md'
    $slidefm = @"
---
title: $title
weight: $weight
navWeight: $navWeight
featured: false
draft: false
comment: false
toc: true
pinned: false
postDate: false
date: $date
index: true
---
<!-- markdownlint-disable MD041 -->

![$title][01]

## $title


<!-- link references -->
[01]: images/platypsv1/$image
"@
    $slidefm | Out-File -FilePath content\docs\10-platypsv1\$slide -Encoding utf8
}

