module Validations::ExtentionUniqCollection
  def push_to_collection(item)
    catch(:exist) do
      collection = proxy_association.reflection.plural_name

      if proxy_association.owner.send(collection).include?(item)
        throw(:exist, "#{collection.singularize.capitalize} with id #{item.id} was already added")
      end

      proxy_association.owner.send(collection).push(item)
    end
  end

  alias_method :<<, :push_to_collection
  alias_method :push, :push_to_collection
end