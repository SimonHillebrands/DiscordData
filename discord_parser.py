import csv
import json
from collections import Counter

def by_value(item):
	return item[1]


def parse(messages):
	total_messages = 0
	total_words = 0
	word_dict = Counter({})
	word_rankings = {}

	for row in messages:
		if(not(total_messages==0)):
			text = row[2]
			text = text.split()
			for word in text:
				word = word.lower()
				if word not in word_dict:
					word_dict[word] = 1
				else:
					word_dict[word] +=1

				total_words+=1
		if(len(row[2])>0):
			total_messages+=1
	# print("Total Messages:\t" + str(total_messages))
	# print("Total Words:\t"+ str(total_words))
	i = len(word_dict)
	for k, v in sorted(word_dict.items(), key=by_value):
		word_rankings[i] = k 
		i -= 1


	message_data = {'messages' : total_messages,'words' : total_words, 'word_counts' : word_dict, 'word_rankings' : word_rankings}

	return message_data

def totals(messages_dict):
	total_words = 0;
	total_messages = 0;
	word_dict = Counter({})
	word_rankings = {}

	output_dict = {}

	for ID, messages in messages_dict.items():
		message_data = parse(messages)

		total_words += message_data['words']
		total_messages += message_data['messages']
		word_dict = word_dict + message_data['word_counts']

		output_dict[ID] = message_data

	with open("message_data.json",'w') as file:
		json.dump(output_dict, file,sort_keys=True, indent=4)



	i = len(word_dict)
	for k, v in sorted(word_dict.items(), key=by_value):
		word_rankings[i] = k 
		i -= 1

	output_totals_dict = {'messages' : total_messages,'words' : total_words, 'word_counts' : word_dict, 'word_rankings' : word_rankings}

	with open("message_data_totals.json",'w') as file:
		json.dump(output_totals_dict, file,sort_keys=True, indent=4)
	# for k, v in sorted(word_dict.items(), key=by_value):
	# 	print(k,'\t:\t',v)
	# print("Total Messages:\t" + str(total_messages))
	# print("Total Words:\t"+ str(total_words))


with open('messages\\index.json') as file:
	index = json.load(file)

id_list = index.keys()
messages = {}
for id in id_list:
	with open('messages\\'+id+'\\messages.csv', newline='',encoding="utf8") as file:
		reader = csv.reader(file)
		messages[id] = list(reader)



#print(parse(messages["752615185457610869"]))
totals(messages)
