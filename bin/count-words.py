#!/usr/bin/env python3
# word count for writingmonth.org
# 2024 - hedy - initial implementation
#             - repurpose into 100DaysToOffload tracker

import os
from datetime import datetime, timedelta
from glob import glob

START = datetime(2024, 11, 1)
COUNT = 0

# def count(file: str):
#     global COUNT
#
#     with open(file) as f:
#         contents = f.read()
#         words = contents.split("+++\n")[2].split()
#         wordcount = len(words)
#         print(file, "\t", wordcount)
#         COUNT += wordcount

last_post = START
posts = {}
postlist = []

for file in glob("content/posts/*"):
    if not os.path.isdir(file):
        continue
    date_s = file.split("/")[2][:10]
    date = datetime.strptime(file.split("/")[2][:10], "%Y-%m-%d")
    posts[date] = True
    slug = file.split("/")[2][11:]
    if date >= START:
        COUNT += 1
        postlist.append(date_s + " " + slug.replace("-", " ").capitalize())
    if date > last_post:
        last_post = date

print("\n".join(sorted(postlist)))
print()
print(START.strftime("%Y-%m-%d"), "..", last_post.strftime("%Y-%m-%d"))
days = (last_post - START).days
print(COUNT, "posts in", days, "days")
print(f"{100 / 365 * days - COUNT:.2f} days behind")

for i in range((datetime.today() - START).days + 1):
    date = START + timedelta(days=i)
    if posts.get(date):
        print("@", end="")
    else:
        print(".", end="")

print()
deltas = [3, 4, 4]
i = 0
j = 0
while j <= days + 1:
    j += deltas[i % len(deltas)]
    i += 1
    print("#" + "." * (deltas[i % len(deltas)] - 1), end="")

print()
