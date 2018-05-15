

class Student:
    def __init__(self, uid, responses):
        self.uid = uid
        self.responses = responses

    def write_responses(self):
        print('{}:{}'.format(self.uid, self.responses))
