<span class="comment-vote">
    <strong>{$ratingsFolder->getRating()}</strong>
    <a class="comment-vote-on" href="{url route="withId" action="on" id=$ratingsFolder->getId()}"> </a>
    <a class="comment-vote-against" href="{url route="withId" action="against" id=$ratingsFolder->getId()}"> </a>
</span>