function exists = F_DataExists(subject,session,labels)
%Description: Verify if the features have been extracted from the data
subjects = labels{:,'Subject'};
sessions = labels{:,'Session'};

subject_exists = any((subjects==subject)==1);
session_exists = any((sessions==session)==1);

if subject_exists && session_exists
    exists = true;
else
    exists = false;
end




