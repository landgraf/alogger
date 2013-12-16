#!/bin/env python

import os

LICENSEFILE = "COPYING.header"

def read_license_file():
    l = open(LICENSEFILE,'r')
    template = l.readlines()
    l.close()
    return template

template = read_license_file()

def insertLicense(filename):
    f = open(filename, 'r')
    lines = f.readlines()
    f.close()
    lines = template + lines
    f = open(filename, 'w')
    for line in lines:
        f.write(line)
    f.close()

def changeLicense(filename):
    f = open(filename, 'r')
    lines = f.readlines()
    f.close()
    body = lines[len(template) - 1 :]
    lines = template + body
    f = open(filename, 'w')
    for line in lines:
        f.write(line)
    f.close()


def isValidLicense(license):
    if license == template:
        return True
    return False

def get_license(filename):
    f = open(filename, 'r')
    license = []
    try:
        for i in xrange(len(template)):
            license.append(f.readline())
    except:
        pass
    f.close()
    if license[0][:5] != ("-"*5) and license[3].find("Copyright") \
            and license[len(template) - 1][:5] != ("-"*5):
        return None
    return license

def updateLicenses(sourceDirectory, pattern):
    for root, dirs, files in os.walk(sourceDirectory):
        for name in files:
            if name.endswith("ads") or name.endswith("adb"):
                fname = os.path.join(root, name)
                if get_license(fname) == None:
                    insertLicense(fname)
                if not isValidLicense(get_license(fname)):
                    changeLicense(fname)

if __name__=="__main__":
    updateLicenses("src/", "*.ads")
    pass
