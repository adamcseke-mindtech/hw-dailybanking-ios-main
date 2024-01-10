#  hw-dailybanking-iOS

The Tech Assessment for Daily Banking iOS developers.


Please always attach the [specification](./specs.md) for the candidate as well.

## Letter

```
Dear [Candidate],

I am happy to let you know that we would like to proceed with your application for
the iOS Software Engineer position. The next step in the process is a technical
assessment completing a technical task.

You can download a skeleton project here, please implement your solution starting
from this. I also attached the instructions about the requirements of the task.

You can use any 3rd party libraries you see fit. I understand there are some technologies
you might not be familiar with - SwiftUI, Combine, etc; this might be a
good opportunity to learn and experiment with some.

We have a 1 week deadline on the assigment. The given task itself should take around 4-6 hours anyway.
Please send your completed task back via zip/email or in a github repo - whichever you prefer.

If you have any questions, please do not hesitate contacting me!

Bests,
[Sender]
```

## Specification

Foundation  -  Mobile  developer  technical  assessment

###  Introduction


Using the application framework provided for you, **create  a  movie  browsing  application** that displays a list of most popular movies, as well as some basic details about them.



###  Implementation  details


-  Use  the  application  framework  provided  for  you.

-  Write  your  application  using  Swift.

-  Host  your  project  on  GitHub.  Use  git  as  you  see  fit.

-  Use  the  latest  version  of  [TMDB  api](https://developers.themoviedb.org/3/getting-started/introduction)  to  fetch  data  about  movies.  An  API  key  will  be  provided  for  you.

-  Create  a  screen  to  show  a  list  of  trending  movies.  Display  some  additional  info  including  the  movie  poster,  title,  its  genres, rating etc. (UI is provided)

-  Selecting  a  movie  from  the  list,  the  user  should  navigate  to  the  detail  page  of  that  movie,  that  displays  some  additional  info. (UI + navigation provided)

- On the details screen the user can mark the movie and add it to their own list (You don't have to persist this data). This status is also visible on the movie list screen. (shared data/state)

-  Please  note  that  TMDB  uses  unique  genre  IDs  that  need  to  be  resolved  using  a  separate  API  call.  Do  not  hardcode  genres  into  your  application.



###  Notes
-  The  application  framework  that  is  provided  for  you  uses  an  MVVM  approach.  We  advise  to  separate  your  code  into  layers  that  you  see  fit  in  this  architecture.

- Instead of proof of concept style solutions, we would be interested how you would implement the task as a scalable solution

