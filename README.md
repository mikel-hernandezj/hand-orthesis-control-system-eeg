# HAND ORTHESIS CONTROL SYSTEM BY MEANS OF EEG SIGNALS

This was a project developed during the PBL (Project Based Learning) phase of our mater's degree in Biomedical Technologies.

## ABSTRACT
During the last years, advancements Brain-Computer Interface (BCI) have allowed
humans to establish direct communication between thoughts and computers.
Electroencephalography (EEG) is a measurement technique that records the neural
oscillations of brain waves that the brain produces at a macro scale. These signals can
be used for applications such as controlling of a robotic prosthetic hand, which at the end
would allow the subject to constantly control it by means of a BCI.

The main goal of this project was to develop a functional BCI that could predict the
motion intention of a subject, distinguishing between resting state and the opening and
closing of either the right or the left hand. Several paradigms were studied and,
finally, motor imagery (MI) was the chosen one. A protocol were created in
order to perform the data acquisition in future experiments. A GUI was developed
for trial rejection both manually and automatically, the latter being based on z-score.
Features were extracted based on statistics, power spectral density (PSD) and phase locking
value (PLV), and the most relevant selected using recursive feature elimination. Various
machine learning models were evaluated using leave-one-subject-out cross-validation
(LOSO-CV) in order to choose a classification model to classify between right, left and
resting cases. The chosen model were support vector machines with a linear kernel
(SVML). This model was tested with different subjects and a mean accuracy of 49%
were obtained.
