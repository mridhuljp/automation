import random

members = ['John','Peter','Paul','Jude','Jacob','John']
queue = []

def oncall():
	i=1
	while (i < 10):
		l = len(queue)
		who = random.randint(0,len(members) -1)
		member = members[who]
		queue.append(member)
		print queue
		#random.shuffle(queue)
		if queue[l -1] in member:
			random.shuffle(queue)
			print queue[l -1] + " to be removed"
		i=i+1

oncall()
