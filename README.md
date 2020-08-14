# Implicit_associates

This is a software for implicit associates method, which was developed for RANEPA Cognitive Lab. 

Made with [Processing](https://processing.org/) 3.5.3 using Java. 

The project has lots of weak points, so, please: **if you use it - improve it** at least a bit.

## If you want to just start using it:
1. Download the latest version of [Processing IDE](https://processing.org/download/)
2. Download the last version of [Java](https://www.java.com/)
3. Download this project, it has all the source code
4. All of the project files must be inside of the folder named "Hope"
5. Open pigpen.pde in Processing IDE
6. Export the project as an application

Processing will generate a folder(s) with executibles and everything you need to run this project.
After that, proceed using it just as any other app. 

## How to access the solution data?
The app saves all recordings in the \*.csv files in the root folder of the app. Column separator is ",", line separator is LF. 

It sores 2 *.csv files - one for all participants' info, the other one for participant's test info. 

**table0.csv:**
- **_ID_** - participant's/computer ID (chosen by the experimenter)
- **_SEX_** - participant's sex (male/female)
- **_AGE_** - participant's age
- **_FIELD_** - participant's field of study/work

Second file is composed of date, time and participant's/computer ID:
**d_m_YYYY_h_m_s_ID.csv:**
- **_ID_** - participant's/computer ID
- **_ACTION_** - state of the program. Possible values:
   - *START* - program start
   - *SSTART** - session start
   - *SHOWCROSS* - the program is showing "+" on the screen
   - *SHOWSTIM* - the program is showing stimulus and categories on the screen, participant can answer
   - *(L)ANS(1/2)* - (Late) answer for category 1/2
- **_TIME_** - timespamp (ms since the start of the app)
- **_SESSION_** - number of the current session
- **_STIMNUMSES_** - order of the stimulus in the current session
- **_STIMNUMLIST_** - order of the stimulus in the list of stimuli. First digit is the number of a stimuli array, second digit is the number of a stimulus inside this array
- **_CORANS_** - number of the correct answer
