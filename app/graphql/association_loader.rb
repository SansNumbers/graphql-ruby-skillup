# frozen_string_literal: true

class AssociationLoader < GraphQL::Batch::Loader
  # TODO: remove model
  def initialize(model, association, scope = nil)
    @model = model
    @association = association
    @scope = scope
  end

  def perform(records)
    preloader = preloader_for_association(records)
    association_class = records&.first&.association(@association)

    read_association =
      if association_class.is_a?(ActiveRecord::Associations::CollectionAssociation)
        method(:read_collection_association)
      else
        method(:read_singular_association)
      end

    records.each do |record|
      fulfill(record, read_association.call(preloader, record))
    end
  end

  private

  def preloader_for_association(records)
    # Before, supplying the scope argument to the `Preloader` would cause the
    # associations for the records to cache the scoped version instead of the
    # non-scoped association. The PR https://github.com/rails/rails/pull/35496
    # fixed that by not caching the scoped associations on the records if a
    # scope was provided. Instead, the PR introduced to the preloader
    # association objects a `records_by_owner` hash that contained the scoped
    # results. Apparently, some in the Rails community were already depending
    # on the internal behavior of the scoped associations' being cached, so
    # that was put back in Rails as the default behavior in
    # https://github.com/rails/rails/pull/40056. However, this subsequent PR
    # also added an `associate_by_default` named parameter to the `Preloader`
    # constructor, so one can opt-out of caching the scoped associations on the
    # records, instead relying on the `records_by_owner` hash to get the
    # associations.
    #
    # For more context on this from the graphql-batch side of things, refer to:
    # https://github.com/Shopify/graphql-batch/issues/77
    if Rails.version < '7'
      ActiveRecord::Associations::Preloader.new(associate_by_default: false).preload(records, @association,
                                                                                     @scope).first
    else
      ActiveRecord::Associations::Preloader.new(
        records: records,
        associations: @association,
        scope: @scope,
        associate_by_default: false
      ).call.first
    end
  end

  def read_collection_association(preloader, record)
    preloader.records_by_owner[record] || []
  end

  def read_singular_association(preloader, record)
    preloader.records_by_owner[record]&.first
  end
end
