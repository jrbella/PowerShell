class Node{

    [string]$value
    [Node]$next_node

    Node($value){
        $this.value = $value
    }

    [string]get_value(){
        return $this.value
    }

    #setting next node
    set_next_node([Node]$next_node){
        $this.next_node = [Node]$next_node
    }

    [Node]get_next_node($next_node){
        return $next_node.get_value
    }
}

#tester
<#
$IronMan = [Node]::new("Tony Stark")
$Hulk = [Node]::new("Bruce Banner")
$BlackWidow = [Node]::new("Sasha Romanov")

$IronMan.set_next_node($Hulk)
$Hulk.set_next_node($BlackWidow)


#>


class LinkedList{

    $head_node = $null

    LinkedList($value){
        $this.head_node = [Node]::new($value)
    }


    [Node]get_head_node(){
        return $this.head_node
    }

    insert_beginning($new_value){
        $new_node = [Node]::new($new_value)
        $new_node.set_next_node($this.head_node)
        $this.head_node = $new_node
    }
    
    [string]stringify_list(){
        $string_list = ""
        $current_node = $this.get_head_node()

        while($current_node){
            if($null -ne $current_node.get_value()){
                $string_list += [string]($current_node.get_value()) + "`n"
                $current_node = $current_node.get_next_node()
            }
        }
        return $string_list
    }
    
    remove_node($value_to_remove){
        $current_node = $this.head_node

        if($this.head_node -eq $value_to_remove){
            $this.head_node = ($this.head_node).get_next_node()
        }
        else{

            while($current_node){
                $next_node = $current_node.get_next_node()
                if($next_node.get_value() -eq $value_to_remove){
                    $current_node.set_next_node($next_node.get_next_node())
                    $current_node = $null
                }
                else{
                    $current_node = $next_node
                }
            }
            
        }
    }
}

Class Stack{

    [Node]$top_item = $null
    [int]$size 
    [int]$limit

    Stack($top_item){
        $this.top_item = $top_item 
    }

    [Node]peek(){
        return $this.top_item.get_value()
    }

    push($value){
        if($this.has_space()){
            $item = [Node]::new($value)
            $item.set_next_node($this.top_item)
            $this.top_item = $item
        }
        else{
            throw "The stack is full"
        }
    }

    [string]pop(){
        $item_to_remove = $this.top_item
        $this.top_item.set_next_node($item_to_remove.get_next_node())
        return $item_to_remove.get_value()
    }

    set_stack_size([int]$value){
        $this.size = $value
    }

    set_stack_limit([int]$value){
        $this.limit = $value
    }

    [Bool]has_space(){
        return $this.limit > $this.size
    }

    #helper
}

class Queue{

    #setting max size to empty and size to 0 for all
    #instances
    $head
    $tail 
    $max_size = $null
    [int]$size = 0

    Queue($head, $tail, $max_size, $size){
        $this.head = $head
        $this.tail = $tail
        $this.max_size = $max_size
    }

    enqueue($value){
        if($this.has_space()){
            $item_to_add = [Node]::new($value)
            Write-Output "Adding " + [string]($item_to_add.get_value()) + " to the queue!"
            if($this.is_empty()){
                $this.head = $item_to_add
                $this.tail = $item_to_add
            }
            else{
                $this.tail.set_next_node($item_to_add)
                $this.tail = $item_to_add
            }
            #adding item to queue, go up by 1
            $this.size += 1
        }
        else{
            Write-Output "Sorry, the queue is full!"
        }
    }

    [Node]dequeue(){
        #needs to remove the head of the queue
        if($this.get_size() -gt 0){
            $item_to_remove = $this.head
            Write-Output "Removing " + [string]($item_to_remove.get_value() + " from the queue!")

            #check if the queue is only 1 set head and tail null
            if($this.get_size() -eq 1){
                $this.head = $null
                $this.tail = $null
            }
            #otherwise just remove the head and set new head node
            #to the next node
            else{
                $this.head = $this.head.get_next_node()
            }
            #size reduced after removing node
            $this.size -= 1
            return $item_to_remove.get_value()
        }
        else:
            #bug here need to figure out
            Write-Output "This queue is empty"
            throw "This queue is empty"
            return "This queue is empty"
    }
    
    [Node]peek(){
        if($this.size -gt 0){
            return $this.head.get_value()
        }
        else:
            return  "Nothing in the Queue"
    }

    [int]get_size(){
        return $this.size
    }

    [Bool]has_space(){
        if($null -eq $this.max_size){
            return True
        }
        else{
            return $this.max_size > $this.get_size()
        }
    }

    [Bool]is_empty(){
        return $this.size == 0
    }
}
<#
$ll = [LinkedList]::new(5)
$ll.insert_beginning(70)
$ll.insert_beginning(237847923)
$ll.insert_beginning(56546)
$ll.insert_beginning(1)
$ll.stringify_list()

$ll.remove_node(237847923)
$ll.stringify_list()


#>

#unit test
<#
Describe  "linked list"{

    It "value is correct"{
        [LinkedList]::new(5) | should -BeOfType "LinkedList"
    }
}

#>