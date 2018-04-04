#!/usr/bin/python3

####################
# Programmed by Luiz Felipe.
# Distributed under the MIT license.
#
# E-mail: felipe.silva337@yahoo.com
# GitHub: https://github.com/Silva97/
####################


from xml.dom.minidom import parse
import argparse, urllib.parse, urllib.request, xml.dom.minidom

parse = argparse.ArgumentParser()
parse.add_argument("-l", "--language", help="The Wikipedia language.", choices=["en", "ja", "ru", "it", "pl", "zh", "fr", "de", "es", "pt"], type=str, default="en")
parse.add_argument("article", help="The name of the article to read/search", type=str)

args = parse.parse_args()

def getText(element, limit):
	txt = ""
	i   = 0
	for E in element.childNodes:
		if E.nodeType == xml.dom.Node.TEXT_NODE:
			txt += E.data
		elif E.childNodes[0].nodeType == xml.dom.Node.TEXT_NODE:
			txt += E.childNodes[0].data
		elif E.childNodes[0].childNodes[0].nodeType == xml.dom.Node.TEXT_NODE:
			txt += E.childNodes[0].childNodes[0].data
		
		i += 1
		if i >= limit and limit != 0:
			break
	return txt

def tagById(tag, ID):
	ret = None
	for T in tag:
		if T.getAttribute("id") == ID:
			ret = T
			break
	
	return ret
	
def isDesambig(content):
	if tagById(content.getElementsByTagName("div"), "disambig") != None:
		return True
	if tagById(content.getElementsByTagName("table"), "disambigbox") != None:
		return True
		
	return False

url     = "https://%s.wikipedia.org/w/index.php" % args.language
search  = urllib.parse.urlencode({ "search": args.article })
file, h = urllib.request.urlretrieve(url + "?" + search)

DOM = xml.dom.minidom.parse(file)
content = DOM.documentElement

tags = content.getElementsByTagName("ul")[1]

if tags.getAttribute("class") == "mw-search-results": # Show search result
	tags = tags.getElementsByTagName("li")
	
	for t in tags:
		print("\033[34;1m**** " + getText(t.childNodes[0].childNodes[0], 0) + " ****\033[00m")
		print( getText(t.childNodes[1], 0) + "[...]\n" )
		
elif isDesambig(content): # Show desambiguation page
	print("\033[32;1m**** Desambiguation page ****\033[00m")
	tags = content.getElementsByTagName("ul")[0]
	for t in tags.childNodes:
		if len(t.childNodes) == 0:
			continue
		if len(t.childNodes) > 1:
			txt = t.childNodes[1].data
		else:
			txt = ""
		print("\033[34;1m" + getText(t.childNodes[0], 0) +"\033[00m"+ txt)
	
else: # Show content of the article
	text = tagById(content.getElementsByTagName("div"), "mw-content-text")
	P    = text.getElementsByTagName("p")
	
	print("\033[34;1m**** " + args.article + " ****\033[00m")
	for i in range(5): # Show the first five paragraphs.
		if i >= len(P):
			break
		print( getText(P[i], 0) + "\n")
